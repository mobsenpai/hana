{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        packages = with pkgs; [
          mariadb
        ];
        shellHook = ''
          MYSQL_BASEDIR=${pkgs.mariadb}
          MYSQL_HOME="$PWD/mysql"
          MYSQL_DATADIR="$MYSQL_HOME/data"
          export MYSQL_UNIX_PORT="$MYSQL_HOME/mysql.sock"
          MYSQL_PID_FILE="$MYSQL_HOME/mysql.pid"

          alias mysql='mysql --socket="$MYSQL_UNIX_PORT" -u root'

          if [ ! -d "$MYSQL_DATADIR" ]; then
            echo "Initializing MySQL data directory..."
            mysql_install_db --no-defaults --auth-root-authentication-method=normal \
              --datadir="$MYSQL_DATADIR" --basedir="$MYSQL_BASEDIR" \
              --pid-file="$MYSQL_PID_FILE"
          fi

          # Start daemon in background
          if [ ! -f "$MYSQL_PID_FILE" ] || ! kill -0 "$(cat "$MYSQL_PID_FILE")" 2>/dev/null; then
            echo "Starting MySQL server..."
            mysqld --no-defaults --skip-networking --datadir="$MYSQL_DATADIR" \
              --pid-file="$MYSQL_PID_FILE" --socket="$MYSQL_UNIX_PORT" \
              2> "$MYSQL_HOME/mysql.log" &
            MYSQL_PID=$!
            sleep 5  # Wait for server to start
          else
            MYSQL_PID="$(cat "$MYSQL_PID_FILE")"
          fi

          finish() {
            echo "Shutting down MySQL server..."
            mysqladmin --socket="$MYSQL_UNIX_PORT" -u root shutdown || true
            kill "$MYSQL_PID" 2>/dev/null || true
            wait "$MYSQL_PID" 2>/dev/null || true
          }

          trap finish EXIT

          echo "MySQL dev environment ready!"
          echo "Data dir: $MYSQL_DATADIR"
          echo "Log: $MYSQL_HOME/mysql.log"
          echo "Connect with: mysql (root user, no password)"
          echo "Type 'exit' to shutdown server."
        '';
      };
    };
  };
}
