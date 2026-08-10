// Terminal status title
//
// Keeps the terminal title informed about what pi is doing right now:
//   ⠸ π · project · edit foo.ts · 12s   working (spinner + current tool + elapsed)
//   ✓ π · project · 1m 05s              finished (with last run duration)
//   ✗ π · project                       run ended in error
//   ■ π · project                       run was aborted
//   ○ π · project                       idle

const DEFAULT_TITLE = "π";
const PREFIX = "π";
const MAX_NAME_LENGTH = 28;
const MAX_ACTIVITY_LENGTH = 28;
const SPINNER_INTERVAL_MS = 120;
const SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

function truncate(text, max) {
  if (!text) return "";
  if (text.length <= max) return text;
  return text.slice(0, max - 1) + "…";
}

function fileName(path) {
  const trimmed = String(path || "").replace(/[\\/]+$/, "");
  if (!trimmed) return "";
  return trimmed.split(/[\\/]/).pop() || "";
}

function basename(path) {
  return fileName(path) || DEFAULT_TITLE;
}

function getSessionName(pi) {
  const name = pi.getSessionName?.();
  return typeof name === "string" ? name.trim() : "";
}

function getRawTitle(pi, ctx) {
  return getSessionName(pi) || basename(ctx.cwd);
}

function isSpinningStatus(status) {
  return status === "working";
}

function statusIndicator(status, spinnerFrame) {
  if (isSpinningStatus(status)) {
    return SPINNER_FRAMES[spinnerFrame % SPINNER_FRAMES.length];
  }

  if (status === "done") return "✓";
  if (status === "error") return "✗";
  if (status === "aborted") return "■";
  return "○";
}

function formatElapsed(ms) {
  const totalSeconds = Math.max(0, Math.floor((ms || 0) / 1000));
  if (totalSeconds < 60) return `${totalSeconds}s`;

  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  if (minutes < 60) return `${minutes}m ${String(seconds).padStart(2, "0")}s`;

  const hours = Math.floor(minutes / 60);
  return `${hours}h ${String(minutes % 60).padStart(2, "0")}m`;
}

// Short human-readable label for a running tool, e.g. "edit foo.ts" or "$ git status".
function describeTool(toolName, args) {
  const a = args && typeof args === "object" ? args : {};

  if (typeof a.path === "string" && a.path) {
    return `${toolName} ${fileName(a.path) || a.path}`;
  }
  if (toolName === "bash" && typeof a.command === "string" && a.command.trim()) {
    return `$ ${a.command.trim()}`;
  }
  if (typeof a.pattern === "string" && a.pattern) return `${toolName} ${a.pattern}`;
  if (typeof a.query === "string" && a.query) return `${toolName} ${a.query}`;

  return toolName || "";
}

function formatTitle(pi, ctx, status, spinnerFrame, activity, elapsedMs) {
  const rawTitle = getRawTitle(pi, ctx);
  const name =
    rawTitle === DEFAULT_TITLE ? DEFAULT_TITLE : `${PREFIX} · ${truncate(rawTitle, MAX_NAME_LENGTH)}`;

  const parts = [statusIndicator(status, spinnerFrame), name];

  if (status === "working") {
    if (activity) parts.push(truncate(activity, MAX_ACTIVITY_LENGTH));
    parts.push(formatElapsed(elapsedMs));
  } else if (status !== "idle" && elapsedMs > 0) {
    parts.push(formatElapsed(elapsedMs));
  }

  return parts.join(" ");
}

// Inspect a finished run's messages and reduce them to an outcome.
function runOutcome(messages) {
  if (!Array.isArray(messages)) return "ok";

  for (let i = messages.length - 1; i >= 0; i--) {
    const message = messages[i];
    if (message?.role !== "assistant") continue;

    if (message.stopReason === "error") return "error";
    if (message.stopReason === "aborted") return "aborted";
    return "ok";
  }

  return "ok";
}

export default function terminalStatusTitle(pi) {
  let status = "idle";
  let spinnerFrame = 0;
  let spinnerInterval;
  let deferredWrite;
  let lastCtx;

  let runStartedAt = 0;
  let finishedElapsed = 0;
  let pendingOutcome; // outcome reported by agent_end, applied on agent_settled
  const activeTools = new Map(); // toolCallId -> label

  function currentActivity() {
    let last = "";
    for (const label of activeTools.values()) last = label;
    return last;
  }

  function clearDeferredWrite() {
    if (!deferredWrite) return;

    clearTimeout(deferredWrite);
    deferredWrite = undefined;
  }

  function writeTitle(ctx = lastCtx) {
    if (!ctx?.hasUI) return;

    lastCtx = ctx;
    const elapsedMs =
      status === "working" ? (runStartedAt ? Date.now() - runStartedAt : 0) : finishedElapsed;
    ctx.ui.setTitle(formatTitle(pi, ctx, status, spinnerFrame, currentActivity(), elapsedMs));
  }

  function stopSpinner() {
    if (!spinnerInterval) return;

    clearInterval(spinnerInterval);
    spinnerInterval = undefined;
    spinnerFrame = 0;
  }

  function startSpinner(ctx) {
    if (!ctx?.hasUI || spinnerInterval) return;

    spinnerFrame = 0;
    spinnerInterval = setInterval(() => {
      if (!isSpinningStatus(status)) {
        stopSpinner();
        return;
      }

      spinnerFrame = (spinnerFrame + 1) % SPINNER_FRAMES.length;
      writeTitle();
    }, SPINNER_INTERVAL_MS);
    spinnerInterval.unref?.();
  }

  function setStatus(nextStatus, ctx) {
    clearDeferredWrite();
    status = nextStatus;
    lastCtx = ctx;

    if (isSpinningStatus(status)) {
      startSpinner(ctx);
    } else {
      stopSpinner();
    }

    writeTitle(ctx);
  }

  function scheduleWrite(ctx) {
    clearDeferredWrite();
    deferredWrite = setTimeout(() => {
      deferredWrite = undefined;
      writeTitle(ctx);
    }, 0);
    deferredWrite.unref?.();
  }

  pi.on("session_start", async (_event, ctx) => {
    runStartedAt = 0;
    finishedElapsed = 0;
    pendingOutcome = undefined;
    activeTools.clear();
    setStatus("idle", ctx);
    scheduleWrite(ctx);
  });

  pi.on("session_info_changed", async (_event, ctx) => {
    // Session renamed via /name — repaint even while idle.
    scheduleWrite(ctx);
  });

  pi.on("agent_start", async (_event, ctx) => {
    runStartedAt = Date.now();
    finishedElapsed = 0;
    pendingOutcome = undefined;
    activeTools.clear();
    setStatus("working", ctx);
  });

  pi.on("tool_execution_start", async (event, ctx) => {
    if (!event.toolCallId) return;

    activeTools.set(event.toolCallId, describeTool(event.toolName, event.args));
    if (status === "working") writeTitle(ctx);
  });

  pi.on("tool_execution_end", async (event, _ctx) => {
    if (event.toolCallId) activeTools.delete(event.toolCallId);
  });

  pi.on("agent_end", async (event, _ctx) => {
    pendingOutcome = runOutcome(event.messages);
  });

  pi.on("agent_settled", async (_event, ctx) => {
    finishedElapsed = runStartedAt ? Date.now() - runStartedAt : 0;
    runStartedAt = 0;
    activeTools.clear();
    setStatus(pendingOutcome === "error" || pendingOutcome === "aborted" ? pendingOutcome : "done", ctx);
    pendingOutcome = undefined;
  });

  pi.on("session_shutdown", async () => {
    clearDeferredWrite();
    stopSpinner();
  });
}
