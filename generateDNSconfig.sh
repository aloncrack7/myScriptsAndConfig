#!/bin/bash

# Usage: ./generate_hosts_script.sh domain1 domain2 ...
# Or: ./generate_hosts_script.sh -f domains.txt

if [[ "$1" == "-f" ]]; then
    if [[ -z "$2" || ! -f "$2" ]]; then
        echo "❌ Please provide a valid domain file after -f" >&2
        exit 1
    fi
    mapfile -t DOMAINS < "$2"
    SCRIPT_NAME="update_hosts_from_file.sh"
else
    if [[ "$#" -eq 0 ]]; then
        echo "❌ Please provide at least one domain or use -f <file>" >&2
        exit 1
    fi
    DOMAINS=("$@")
    SCRIPT_NAME="update_hosts.sh"
fi

# Start generating the script
cat << EOF > "$SCRIPT_NAME"
#!/bin/bash

# Check if running as root
if [[ "\$EUID" -ne 0 ]]; then
  echo "❌ This script must be run with sudo or as root." >&2
  exit 1
fi

# Check if IP address is provided
if [[ -z "\$1" ]]; then
  echo "❌ Usage: sudo \$0 <IP_ADDRESS>" >&2
  exit 1
fi

IP="\$1"

# Define the hostnames
HOSTS=(
EOF

# Add each domain
for DOMAIN in "${DOMAINS[@]}"; do
    echo "    \"$DOMAIN\"" >> "$SCRIPT_NAME"
done

# Continue generating the script (note: no single quotes here)
cat << EOF >> "$SCRIPT_NAME"
)

# Backup the original /etc/hosts
cp /etc/hosts /etc/hosts.bak

# Remove any existing entries for these hostnames
for HOST in "\${HOSTS[@]}"; do
    sed -i "/[[:space:]]\$HOST\$/d" /etc/hosts
done

# Add new entries
for HOST in "\${HOSTS[@]}"; do
    echo -e "\$IP\t\$HOST" >> /etc/hosts
done

echo "✅ /etc/hosts updated successfully with IP \$IP"
EOF

chmod +x "$SCRIPT_NAME"
echo "✅ Generated script: $SCRIPT_NAME"
