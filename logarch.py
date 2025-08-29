#!/usr/bin/env python3

import os
import tarfile
import argparse
import logging
from datetime import datetime
import smtplib
from email.mime.text import MIMEText
from pathlib import Path

# --- Configure Your Email Details Here ---
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USER = 'abc@gmail.com'
SMTP_PASSWORD = 'your-app-password' # For Gmail, use an "App Password"

def main():
    parser = argparse.ArgumentParser(description="A tool to compress and archive log files.")
    parser.add_argument("log_directory", help="The path to the log directory to archive.")
    parser.add_argument("--email", help="Email address to send a notification to.")
    args = parser.parse_args()

    # Set up a directory in your home folder to store the archives
    archive_storage_dir = Path.home() / 'log_archives'
    archive_storage_dir.mkdir(exist_ok=True)

    # Set up a log file for this script's activity
    log_file = archive_storage_dir / 'archiver_activity.log'
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()
        ]
    )

    logging.info("--- Log Archiver Tool Started ---")

    log_dir_path = Path(args.log_directory)

    if not log_dir_path.is_dir():
        logging.error(f"Error: The directory '{log_dir_path}' does not exist.")
        return

    try:
        # Create a unique, timestamped filename
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        archive_name = f'logs_archive_{timestamp}.tar.gz'
        archive_path = archive_storage_dir / archive_name

        logging.info(f"Compressing '{log_dir_path}' to '{archive_path}'...")
        with tarfile.open(archive_path, "w:gz") as tar:
            tar.add(log_dir_path, arcname=log_dir_path.name)
        logging.info("Successfully created archive.")

        # Send an email if an address was provided
        if args.email:
            logging.info(f"Sending email notification to {args.email}...")
            subject = f"Log Archive Successful: {log_dir_path.name}"
            body = f'''\nThe log directory '{log_dir_path}' has been successfully archived to:\n{archive_path}
            \nHogya bc.'''
            
            msg = MIMEText(body)
            msg['Subject'] = subject
            msg['From'] = SMTP_USER
            msg['To'] = args.email

            try:
                with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
                    server.starttls()
                    server.login(SMTP_USER, SMTP_PASSWORD)
                    server.sendmail(SMTP_USER, [args.email], msg.as_string())
                logging.info("Email sent successfully.")
            except Exception as e:
                logging.error(f"Failed to send email: {e}")

    except Exception as e:
        logging.error(f"An error occurred during archiving: {e}")

    logging.info("--- Log Archiver Tool Finished ---")


if __name__ == '__main__':
    main()

