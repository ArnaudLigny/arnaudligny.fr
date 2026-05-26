const { test, expect } = require('@playwright/test');

test('la page d\'accueil charge correctement', async ({ page }) => {
  await page.goto('/');

  await expect(page).toHaveTitle(/Consultant fonctionnel|Arnaud Ligny/i);
  await expect(page.locator('main')).toBeVisible();
});

test('la page a-propos est accessible', async ({ page }) => {
  await page.goto('/a-propos/');

  await expect(page.locator('h1')).toContainText(/A propos|À propos/i);
});

test('la page blog est accessible', async ({ page }) => {
  await page.goto('/blog/');

  await expect(page).toHaveURL(/\/blog\/?$/);
  await expect(page.locator('main')).toBeVisible();
});
