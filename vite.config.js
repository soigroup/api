import { defineConfig } from 'vite';
import laravel from 'vite-plugin-laravel'; // تأكد من استيراد المكتبة

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
    ],
    build: {
        outDir: 'public/build',
        manifest: true, // تأكد من إنشاء manifest.json
    },
});
