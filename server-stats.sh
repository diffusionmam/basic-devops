get_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "CPU Usage: $CPU_USAGE%"
}

get_memory_usage(){
    MEMORY_USAGE=$(free -m| awk 'NR==2{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4}')
    echo "Memory usage: $MEMORY_USAGE%"
}

get_disk_usage(){
    DISK_USAGE=$(df -h / | awk 'NR==2{print "Total: "$4" ("$5" used), Used: "$3", Free: "$2"\n"}')
    echo "Disk usage: $DISK_USAGE"
}

monitor_server(){
    get_cpu_usage
    get_memory_usage
    get_disk_usage
}

monitor_server