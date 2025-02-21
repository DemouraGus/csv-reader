require 'csv'

file_path = "inconsistent_data.csv"

data = CSV.read(file_path, headers: true).map(&:to_h)

def format_name(name)
  name.split.map(&:capitalize).join(' ')
end

def format_email(email)
  email.strip.downcase
end

def format_phone(phone)
  digits = phone.gsub(/\D/, '')

  if digits.length == 10
    "(#{digits[0..2]}) #{digits[3..5]}-#{digits[6..9]}"
  else
    "INVALID"
  end
end

output_file = "cleaned_data.csv"

CSV.open(output_file, "w") do |csv|
  csv << ["Name", "Email", "Phone Number"]

  data.each do |row|
    csv << [
      format_name(row["Name"]),
      format_email(row["Email"]),
      format_phone(row["Phone Number"])
    ]
  end
end

puts "Cleaned data saved to #{output_file}"