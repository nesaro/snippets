import sys

def next_time(task_hour, task_minute, target_hour, target_minute):
    """Returns the next execution after the target time"""
    carry_hour = 0
    tomorrow = False
    if task_minute == '*' and task_hour in ('*',target_hour):
        minute = target_minute
    elif task_minute == '*':
        minute = 0
    else:
        minute = task_minute
        if minute < target_minute:
            carry_hour = 1
    if task_hour == '*':
        hour = target_hour + carry_hour
    else:
        hour = task_hour
        if hour < target_hour + carry_hour:
            tomorrow = True
    if hour > 23:
        hour = 0
        tomorrow = True
    return hour, minute, tomorrow

def parse_input(line):
    """Converts a single input line into a tuple"""
    hour, minute, command = line.split(' ', 2)
    if hour != '*':
        hour = int(hour)
    if minute != '*':
        minute = int(minute)
    return hour, minute, command

def result_to_string(hour, minute, tomorrow, command):
    day = "today"
    if tomorrow:
        day = "tomorrow"
    return "%d:%02d %s - %s" % (hour, minute, day, command)
        
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: prog HH:MM")
        sys.exit(-1)

    target_hour, target_minute = sys.argv[1].split(':')
    target_hour = int(target_hour)
    target_minute = int(target_minute)
    for line in sys.stdin:
        minute, hour, command = parse_input(line)
        result_hour, result_minute, tomorrow = next_time(hour, minute, target_hour, target_minute)
        result_string = result_to_string(result_hour, result_minute, tomorrow, command)
        sys.stdout.write(result_string)

    
