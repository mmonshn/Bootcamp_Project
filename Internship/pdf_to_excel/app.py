import os
import re
import shutil
import tabula
import PyPDF2
import openpyxl
import pandas as pd
from datetime import datetime

# Read the PDF file and store the data in a list.
def read_pdf_all(file_path):
    file_data = tabula.read_pdf(file_path, pages='all')
    data_list = pd.concat(file_data)
    return data_list

# Preprocess the data by selecting columns, dropping rows with all NaN values.
def preprocess_data(data_list):
    edit_cols = data_list.iloc[:, [1, 5, 6]]
    edit_cols.rename(columns={edit_cols.columns[0]: 'รหัส', edit_cols.columns[1]: 'เข้า', edit_cols.columns[2]: 'ออก'}, inplace=True)
    edit_cols = edit_cols.dropna(subset=['รหัส', 'เข้า', 'ออก'], how='all')
    edit_cols['รหัส'] = edit_cols['รหัส'].astype(str).str.split('.').str[0]
    edit_cols['เข้า'] = pd.to_datetime(edit_cols['เข้า'], format='%H:%M', errors='coerce').dt.time
    edit_cols['ออก'] = pd.to_datetime(edit_cols['ออก'], format='%H:%M', errors='coerce').dt.time
    return edit_cols

# Extract the date from the file name.
def extract_date(file_path):
    with open(file_path, "rb") as file:
        pdf_reader = PyPDF2.PdfReader(file)
        num_pages = len(pdf_reader.pages)

        extracted_text = []
        for page_number in range(num_pages):
            page = pdf_reader.pages[page_number]
            extracted_text.append(page.extract_text())

    # Initialize a variable to store the matched date
    matched_date = None

    for line in extracted_text:
        matchs = re.search(r"ประจำวันที่ (\d{2}/\d{2}/\d{4})", line)
        if matchs:
            matched_date = matchs.group(1)
            break  # Exit the loop if a match is foun
    return matched_date

# Save the data as an Excel file.
def save_as_excel(data, file_name, success_path):
    file_name = os.path.splitext(file_name)[0]
    result_file_name = f"{file_name}.xlsx"
    success_file = os.path.join(success_path, result_file_name)
    data.to_excel(success_file, index=False)
    print(f"Processed: {file_name} -> {success_file}")

# Move the failed file to the fail_path.
def move_failed_file(file_path, fail_path):
    fail_file = os.path.join(fail_path, os.path.basename(file_path))
    shutil.move(file_path, fail_file)
    print(f"Failed to process: {file_path} -> {fail_file}")

def convert_pdf_to_excel(file_name, file_path, success_path, fail_path):
    try:
        data_list = read_pdf_all(file_path)
        processed_data = preprocess_data(data_list)
        matched_date = extract_date(file_path)
        processed_data['วันที่'] = matched_date
        save_as_excel(processed_data, file_name, success_path)
        os.remove(file_path)
    except Exception as e:
        move_failed_file(file_path, fail_path)
        print(f"Error: {str(e)}")

def process_data(data_path):
    for root, dirs, files in os.walk(data_path):
        if root != data_path:
            success_path = os.path.join(root, "success")
            fail_path = os.path.join(root, "fail")
            os.makedirs(success_path, exist_ok=True)
            os.makedirs(fail_path, exist_ok=True)
            for file_name in files:
                if file_name.endswith(".pdf"):
                    file_path = os.path.join(root, file_name)
                    convert_pdf_to_excel(file_name, file_path, success_path, fail_path)

# Specify the folder path containing the PDF files
# my_DATA_PATH = os.getenv("DATA_PATH")
# print(f"DATA_PATH -> {my_DATA_PATH}")
data_path = r"\Users\MSII\Downloads\ta_pdf_extracter\data\2023 05 01-07"
# Process the data
process_data(data_path)
