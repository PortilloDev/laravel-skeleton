# Laravel 12 Project Template

> **Starter kit for modern Laravel development** – opinionated setup with Docker, quality‑gate hooks and ready‑to‑scale defaults, now with Xdebug 3.

---

## ✨ Key Features

| Area            | Tooling / Configuration                                     |
| --------------- | ----------------------------------------------------------- |
| **Runtime**     | PHP 8.4‑FPM, Alpine image                                   |
| **Web Server**  | Nginx 1.27 │ hot‑reloaded via volume mounts                 |
| **Data Stores** | MySQL 8.4 & Redis 7.2 (Docker)                              |
| **Quality**     | **PHPStan** (max level) • **PHP‑CS‑Fixer** (Symfony preset) |
| **Testing**     | PHPUnit (Laravel test suite pre‑configured)                 |
| **Automation**  | Git **pre‑commit** hook → CS‑Fixer › PHPStan › PHPUnit      |
| **Debugging**   | IDE‑friendly Xdebug on port 9003                            |

---

## 🚀 Quick Start

```bash
# Clone the template (GitHub → "Use this template")
 git clone <repo‑url> my‑project && cd my‑project

# PHP dependencies
 composer install

# Environment
 cp .env.example .env
 php artisan key:generate

# Containers (app, nginx, mysql, redis)
 docker compose up -d
```

> **Tip:** all service ports are overridable through environment variables (see below).

---

## 🔍 Static Analysis & Coding Style

1. **Activate the hook** (one‑time):

   ```bash
   chmod +x .githooks/pre-commit
   git config core.hooksPath .githooks
   ```
2. Every `git commit` runs:

   * `php-cs-fixer fix --dry-run --diff`
   * `phpstan analyse`
   * `phpunit`

   The commit is rejected on the first failure, keeping `main` green at all times.

---

## 🐳 Docker Services & Port Mapping

| Service       | Image                | Env Var      | Default Host Port |
| ------------- | -------------------- | ------------ | ----------------- |
| App (PHP‑FPM) | `php:8.4-fpm-alpine` | `APP_PORT`   | **9000**          |
| Nginx         | `nginx:1.27-alpine`  | `NGINX_PORT` | **8080**          |
| MySQL         | `mysql:8.4`          | `MYSQL_PORT` | **3306**          |
| Redis         | `redis:7.2-alpine`   | `REDIS_PORT` | **6379**          |
| Xdebug        | `built‑in`           | `XDEBUG_PORT`| **9003**          |

To change a port, export the variable before `docker compose up`, for example:

```bash
export MYSQL_PORT=3307
```
---

## 🐞 Debugging with Xdebug
1 IDE configuration – listen on the same port as XDEBUG_PORT (default 9003).
2 Ensure XDEBUG_MODE=debug (already default) and XDEBUG_CLIENT_HOST points to your host:
```bash
export XDEBUG_CLIENT_HOST=$(ip route | awk '/default/ {print $3}')
docker compose up -d
```
Place a breakpoint in your code and send a request – Laravel will pause inside your IDE.

Disable Xdebug (for performance) by setting XDEBUG_MODE=off and docker compose restart app

---

## 🧪 Running Tests

```bash
vendor/bin/phpunit  # or simply `php artisan test`
```

Add `--parallel` if you enable Paratest in `phpunit.xml`.

---

## 📜 License

Released under the MIT License – see `LICENSE` file for details.

---

## 🤝 Contributing

Pull requests are welcome! Please make sure the pipeline passes and your code follows the existing style rules.

---

## 📬 Contact

Feel free to reach out on [LinkedIn](https://www.linkedin.com/in/ivan-portillo-perez) if you have any questions or suggestions.

---

Happy coding & debugging 🎉
