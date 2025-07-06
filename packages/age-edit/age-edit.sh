if [ $# -lt 1 ]; then
    exit 1
fi

secret="$1"
shift

host="$(uname -n)"
user="$USER"

while [[ $# -gt 0 ]]; do
    case "$1" in
    -h | --host)
        host="$2"
        shift 2
        ;;
    -u | --user)
        user="$2"
        shift 2
        ;;
    *)
        break
        ;;
    esac
done

secrets_dir="./secrets"
file_name="$secret.age"
source_path="$(realpath -m "$secrets_dir/$host/$user/$file_name")" || exit 1
tmp_dir="$(mktemp -d)"
decrypt_file="$tmp_dir/$secret.txt"
encrypt_file="$tmp_dir/$secret.age"

if [ -f "$source_path" ]; then
    identity_paths=(
        "$HOME/.ssh/id_rsa"
        "$HOME/.ssh/id_ed25519"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_ed25519_key"
    )

    decrypt_args=(--decrypt -o "$decrypt_file")
    for identity in "${identity_paths[@]}"; do
        if [ -r "$identity" ]; then
            decrypt_args+=(--identity "$identity")
        fi
    done

    age "${decrypt_args[@]}" -- "$source_path" || exit 1
else
    touch "$source_path"
    touch "$decrypt_file"
fi

keys_json="$(
    nix eval --impure --json --expr "(import $secrets_dir/recipients.nix).\"$source_path\"" 2>/dev/null ||
        nix eval --impure --json --expr "(import $secrets_dir/keys.nix).$host.$user.all"
)" || exit 1

keys=$(echo "$keys_json" | jq -r .[])

encrypt_args=(--encrypt -o "$encrypt_file")
while read -r key; do
    if [ -n "$key" ]; then
        encrypt_args+=(--recipient "$key")
    fi
done <<<"$keys"

${EDITOR:=nvim} "$decrypt_file"

age "${encrypt_args[@]}" -- "$decrypt_file" || exit 1
mv -f -- "$encrypt_file" "$source_path"
