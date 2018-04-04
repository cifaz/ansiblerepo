## GitLab configuration settings

external_url 'http://{{gitlab-ce-url}}:{{gitlab-ce-port}}'

gitlab_rails['backup_keep_time'] = 1814400

git_data_dirs({
  "default" => {
    "path" => "{{gitlab-ce-repo-dir}}"
   }
})

nginx['listen_port'] = {{gitlab-ce-port}}
