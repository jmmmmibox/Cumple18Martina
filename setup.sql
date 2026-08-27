-- =============================================
-- SETUP SUPABASE - Web Cumpleaños Martina 18
-- Pega esto en: Supabase → SQL Editor → New query
-- =============================================

-- 1. FIRMAS
CREATE TABLE IF NOT EXISTS firmas (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre text NOT NULL,
  mensaje text,
  firma_svg text,
  foto_url text,
  created_at timestamptz DEFAULT now()
);

-- 2. MURO DE DESEOS
CREATE TABLE IF NOT EXISTS deseos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre text NOT NULL,
  mensaje text NOT NULL,
  color text DEFAULT '#fff9c4',
  created_at timestamptz DEFAULT now()
);

-- 3. VIDEOS
CREATE TABLE IF NOT EXISTS videos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre text NOT NULL,
  video_url text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 4. VOTOS / PREMIOS
CREATE TABLE IF NOT EXISTS votos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  votante text NOT NULL,
  categoria text NOT NULL,
  nominado text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 5. GALERIA (fotos subidas por invitados)
CREATE TABLE IF NOT EXISTS galeria (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre text NOT NULL,
  foto_url text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 6. RAZONES (18 razones para quererte)
CREATE TABLE IF NOT EXISTS razones (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  autor text NOT NULL,
  razon text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 7. MENSAJE SORPRESA
CREATE TABLE IF NOT EXISTS mensaje_sorpresa (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  autor text NOT NULL,
  mensaje text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- =============================================
-- HABILITAR RLS + POLÍTICAS PÚBLICAS
-- =============================================

ALTER TABLE firmas ENABLE ROW LEVEL SECURITY;
ALTER TABLE deseos ENABLE ROW LEVEL SECURITY;
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;
ALTER TABLE votos ENABLE ROW LEVEL SECURITY;
ALTER TABLE galeria ENABLE ROW LEVEL SECURITY;
ALTER TABLE razones ENABLE ROW LEVEL SECURITY;
ALTER TABLE mensaje_sorpresa ENABLE ROW LEVEL SECURITY;

CREATE POLICY "read_firmas" ON firmas FOR SELECT USING (true);
CREATE POLICY "insert_firmas" ON firmas FOR INSERT WITH CHECK (true);

CREATE POLICY "read_deseos" ON deseos FOR SELECT USING (true);
CREATE POLICY "insert_deseos" ON deseos FOR INSERT WITH CHECK (true);

CREATE POLICY "read_videos" ON videos FOR SELECT USING (true);
CREATE POLICY "insert_videos" ON videos FOR INSERT WITH CHECK (true);

CREATE POLICY "read_votos" ON votos FOR SELECT USING (true);
CREATE POLICY "insert_votos" ON votos FOR INSERT WITH CHECK (true);

CREATE POLICY "read_galeria" ON galeria FOR SELECT USING (true);
CREATE POLICY "insert_galeria" ON galeria FOR INSERT WITH CHECK (true);

CREATE POLICY "read_razones" ON razones FOR SELECT USING (true);
CREATE POLICY "insert_razones" ON razones FOR INSERT WITH CHECK (true);

CREATE POLICY "read_sorpresa" ON mensaje_sorpresa FOR SELECT USING (true);
CREATE POLICY "insert_sorpresa" ON mensaje_sorpresa FOR INSERT WITH CHECK (true);

-- =============================================
-- STORAGE BUCKET para fotos y videos
-- =============================================
INSERT INTO storage.buckets (id, name, public)
VALUES ('martina18', 'martina18', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "public_upload" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'martina18');

CREATE POLICY "public_read_storage" ON storage.objects
  FOR SELECT USING (bucket_id = 'martina18');
