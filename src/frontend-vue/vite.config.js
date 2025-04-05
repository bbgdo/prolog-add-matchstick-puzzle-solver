import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
    plugins: [vue()],
    server: {
        proxy: {
            '/game_add_1': 'http://localhost:4567',
            '/game_add_2': 'http://localhost:4567'
        }
    }
})
