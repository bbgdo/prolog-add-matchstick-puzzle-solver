# 🧩 Matches Puzzle

This is a full-stack web app that solves **matchstick equations** – arithmetic expressions where digits can be transformed into other digits by **moving one or two matchsticks**.

---

## ⚙️ Technologies

- 🟡 **Java + SWI-Prolog** (via [JPL](https://jpl7.org/))
- 🟢 **Vue 3** (via [Vite](https://vitejs.dev/))
- 🧠 **Prolog-based logic engine** — all the matching logic lives there!

---

## 🚀 Project Setup

### 1️⃣ Backend (Java + Prolog)

#### Requirements:
- JDK 8+
- Maven
- [SWI-Prolog](https://www.swi-prolog.org/) installed and available in your system path

#### Launch:

```bash
cd src/backend-java
mvn compile
mvn exec:java -Dexec.mainClass=PrologJavaServer
```
🟢 Server will run at: http://localhost:4567

### 2️⃣ Frontend (Vue 3)

#### Requirements:
- Node.js (v16+ recommended)
- NPM

#### Launch:

```bash
cd src/frontend-vue
npm install
npm run dev
```
🟢 App will open at: http://localhost:5173

### 🎓 Credits

The core solving algorithm was based on version for removing matchsticks:

> 🔗 https://github.com/nxxtia/PuzzleWithMatches
> 
> ✍️ Author: Anastasiia Chyzhova

Huge thanks for the original matchstick solver logic in Prolog!