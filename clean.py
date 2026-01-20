import pandas as pd

# Load raw data
file_path = "sales_raw_data.xlsx"  # place this in same folder
df = pd.read_excel(file_path)

print("Raw Data Preview:")
print(df.head())

# --- Data Cleaning ---

# Fix Date column (mixed formats)
df["Date"] = pd.to_datetime(df["Date"], errors="coerce")

# Convert Quantity and UnitPrice to numeric
df["Quantity"] = pd.to_numeric(df["Quantity"], errors="coerce")
df["UnitPrice"] = pd.to_numeric(df["UnitPrice"], errors="coerce")

# Handle missing values
df["Quantity"].fillna(df["Quantity"].median(), inplace=True)
df["UnitPrice"].fillna(df["UnitPrice"].median(), inplace=True)

# Remove rows with invalid dates
df = df.dropna(subset=["Date"])

# --- Feature Engineering ---

# Revenue
df["Revenue"] = df["Quantity"] * df["UnitPrice"]

# Time features
df["Month"] = df["Date"].dt.month
df["Year"] = df["Date"].dt.year
df["MonthName"] = df["Date"].dt.strftime("%b")

# Sort by date
df = df.sort_values("Date")

print("\nCleaned Data Preview:")
print(df.head())

# Export cleaned data
output_path = "sales_cleaned_data.xlsx"
df.to_excel(output_path, index=False)

print(f"\nCleaned file saved as: {output_path}")
