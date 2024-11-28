use clap::Parser;
use std::io::{self, Write};
use std::process::Command;
use std::sync::{Arc, Mutex};
use std::thread;
use std::time;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(help = "Language name")]
    lang: String,

    #[arg(help = "Command to run")]
    cmd: String,
}

fn main() {
    let args = Args::parse();
    bench(&args.lang, &args.cmd);
}

fn loading_animation(msg: &str, stop: &Arc<Mutex<bool>>) {
    let chars = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
    let mut i = 0;
    while !*stop.lock().unwrap() {
        print!("\r{} {}", msg, chars[i]);
        io::stdout().flush().unwrap();
        i = (i + 1) % chars.len();
        thread::sleep(time::Duration::from_millis(100));
    }
}

fn bench(lang: &str, cmd: &str) {
    let stop = Arc::new(Mutex::new(false));
    let stop_clone = Arc::clone(&stop);
    let msg = format!("{}:", lang);
    let handle = thread::spawn(move || {
        loading_animation(&msg, &stop_clone);
    });

    let start_time = time::Instant::now();
    Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .output()
        .expect("Failed to execute command");
    let duration = start_time.elapsed();

    *stop.lock().unwrap() = true;
    handle.join().unwrap();
    let out = format!("{}: {}ms", lang, duration.as_millis());
    let whitespaces = " ".repeat(out.len());
    println!("\r{}{}", out, whitespaces);
}
