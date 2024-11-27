import os
from termcolor import colored

def print_header():
    header = """
╔══════════════════════════════════════════╗
║         Language Benchmark Results        ║
╚══════════════════════════════════════════╝"""
    print(colored(header, 'cyan', attrs=['bold']))

def print_separator():
    print(colored("─" * 45, 'blue'))

def read_results():
    """Read benchmark results from temporary file."""
    results = {}
    try:
        with open('/tmp/benchmark_results', 'r') as f:
            for line in f:
                if '=' in line:
                    lang, time = line.strip().split('=')
                    lang = lang.strip()
                    try:
                        time = float(time.strip().replace('s', ''))
                        # Keep only valid times (greater than 0)
                        if time > 0:
                            # Keep the fastest time for each language
                            if lang not in results or time < results[lang]:
                                results[lang] = time
                    except ValueError:
                        # Skip invalid time values
                        continue
    except FileNotFoundError:
        print(colored("⚠️  No benchmark results found!", 'red'))
        return {}
    return results

def print_results(results):
    if not results:
        return
    
    print(colored("\n📊 Benchmark Results:", 'green', attrs=['bold']))
    print_separator()
    
    # Find the fastest time for highlighting
    fastest_time = min(results.values()) if results else 0
    
    # Print results in a table format
    print(f"{'Language':<15} {'Time (s)':<10} {'Bar':<20}")
    print_separator()
    
    for lang, time in sorted(results.items(), key=lambda x: x[1]):
        # Create a visual bar
        bar_length = int((time / max(results.values()) * 20))
        bar = "█" * bar_length
        
        # Color coding
        if time == fastest_time:
            lang_str = colored(f"{lang:<15}", 'green', attrs=['bold'])
            time_str = colored(f"{time:<10.3f}", 'green', attrs=['bold'])
            bar = colored(bar, 'green')
        else:
            lang_str = colored(f"{lang:<15}", 'white')
            time_str = colored(f"{time:<10.3f}", 'white')
            bar = colored(bar, 'blue')
        
        print(f"{lang_str}{time_str}{bar}")

def main():
    print_header()
    results = read_results()
    print_results(results)
    if results:
        print(colored("\n✨ Benchmark complete! ✨\n", 'yellow', attrs=['bold']))
        fastest_lang = min(results.items(), key=lambda x: x[1])[0]
        print(colored(f"🏆 Fastest language: {fastest_lang}\n", 'yellow', attrs=['bold']))

if __name__ == '__main__':
    main()
