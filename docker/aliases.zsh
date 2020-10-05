dkr() {
  case "$1" in
      # kill all running containers
      "kill")
        docker kill $(docker ps -q)
        ;;
      # remove all containers
      "rmc")
        docker rm $(docker ps -a -q)
        ;;
      # remove all images
      "rmi")
        docker rmi $(docker images -q)
        ;;
      # reset
      "reset")
        dkr kill
        docker network prune -f
        dkr rmc
        dkr rmi
        ;;
      *)
        echo "Invalid option $1"
        ;;
    esac
}
