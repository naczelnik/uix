/*
  # Dodanie kolumny photo_url do tabeli trainers

  1. Zmiany w schemacie
    - Dodanie kolumny `photo_url` do tabeli `trainers`
    - Kolumna opcjonalna (nullable) dla URL zdjęcia trenera

  2. Bezpieczeństwo
    - Brak zmian w politykach RLS - kolumna dziedziczy istniejące zasady
*/

-- Dodanie kolumny photo_url do tabeli trainers
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'trainers' AND column_name = 'photo_url'
  ) THEN
    ALTER TABLE trainers ADD COLUMN photo_url text;
  END IF;
END $$;