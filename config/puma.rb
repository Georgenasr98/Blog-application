# config/puma.rb

# Number of threads per worker
threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

# Bind to 0.0.0.0 to accept connections from outside the container
port ENV.fetch("PORT", 3000)

# Allow Puma to be restarted by `bin/rails restart` command
plugin :tmp_restart

# PID file configuration (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
