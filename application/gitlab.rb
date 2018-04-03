## GitLab configuration settings

external_url 'http://192.168.0.199:9000'

gitlab_rails['backup_keep_time'] = 1814400

git_data_dirs({
  "default" => {
    "path" => "/app/data/gitlab"
   }
})

nginx['listen_port'] = 9000
