#!/bin/bash

# Available service files
declare -A services=(
  ["1"]="proxy"
  ["2"]="webapp"
  ["3"]="server"
  ["4"]="gotenberg"
)

echo "Which service(s) do you want to run?"
echo "Select one or more numbers (space-separated):"
for i in "${!services[@]}"; do
  echo "  $i) ${services[$i]}"
done

read -r -p "Enter your choice(s): " -a choices

# Validate and build list of compose files
compose_files="-f docker-compose.base.yml"
for choice in "${choices[@]}"; do
  service="${services[$choice]}"
  if [ -n "$service" ]; then
    compose_files="$compose_files -f docker/compose/${service}.yml"
  else
    echo "Invalid option: $choice"
    exit 1
  fi
done

echo "What do you want to do? (up/down/restart/logs/build/ps):"
read -r action

# Validate action
if [[ "$action" != "up" && "$action" != "down" && "$action" != "restart" && "$action" != "logs" && "$action" != "build" && "$action" != "ps" ]]; then
  echo "Invalid action: $action"
  exit 1
fi

# Run the selected services
if [[ "$action" == "logs" ]]; then
  echo "Select a service for logs:"
  for i in "${!services[@]}"; do
    echo "  $i) ${services[$i]}"
  done
  read -r -p "Enter your choice: " log_choice
  target_service="${services[$log_choice]}"

  if [ -n "$target_service" ]; then
    echo "Running: ${compose_files}"
    docker compose $compose_files logs -f $target_service
  else
    echo "Invalid option: $log_choice"
    exit 1
  fi
elif [[ "$action" == "up" || "$action" == "restart" ]]; then
  echo "Running: ${compose_files}"
  docker compose $compose_files $action -d
else
  echo "Running: ${compose_files}"
  docker compose $compose_files $action
fi