#!/usr/bin/env fish

# Install fisher
# https://github.com/jorgebucaran/fisher
set -x fisher_path $__fish_user_data_dir/fisher

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
