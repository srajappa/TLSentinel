#include <linux/bpf.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/tls.h>
#include <bpf/bpf_helpers.h>

struct tls_failure_event {
    u64 timestamp;
    char host[256];
    char reason[128];
};

struct {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
} tls_fail_events SEC(".maps");

SEC("kprobe/do_handshake")
int tls_failure_probe(struct pt_regs *ctx) {
    struct tls_failure_event event = {};
    event.timestamp = bpf_ktime_get_ns();

    // Simulate extracting the hostname and failure reason
    bpf_probe_read_str(event.host, sizeof(event.host), "example.com");
    bpf_probe_read_str(event.reason, sizeof(event.reason), "Invalid Certificate");

    // Send event to user space
    bpf_perf_event_output(ctx, &tls_fail_events, BPF_F_CURRENT_CPU, &event, sizeof(event));
    return 0;
}

char _license[] SEC("license") = "GPL";
