# Nombre del Workflow
name: Ejecutar Script y Crear Backup

# Disparador: Se ejecuta en cada 'push' a la rama principal
on:
  push:
    branches:
      - master # Asegúrate que coincida con tu rama principal (ej. main o master)

jobs:
  # --- TRABAJO 1: Ejecutar el script 'hello.sh' ---
  run_hello_script:
    # Se ejecuta en una máquina virtual de Ubuntu
    runs-on: ubuntu-latest
    
    steps:
      # 1. Descarga el código del repositorio
      - name: Checkout code
        uses: actions/checkout@v5

      # 2. Da permisos de ejecución al script
      - name: Give execution permissions
        run: chmod +x src/hola.sh

      # 3. Ejecuta el script
      - name: Run hola script
        run: ./src/hola.sh

  # --- TRABAJO 2: Crear el backup de 'datos' ---
  create_backup:
    # Se ejecuta en una máquina virtual de Ubuntu
    runs-on: ubuntu-latest
    
    steps:
      # 1. Descarga el código del repositorio
      - name: Checkout code
        uses: actions/checkout@v5

      # 2. Crea la carpeta 'backup' donde guardaremos el comprimido
      # (Esta carpeta solo existe dentro del entorno de la Action)
      - name: Create backup directory
        run: |
          mkdir -p backup
          ls -l

      # 3. Comprime la carpeta 'datos' en un archivo .tar.gz
      - name: Create compressed backup (tar.gz)
        # c=crear, z=gzip, v=verbose, f=archivo
        # Salida: backup/datos-backup.tar.gz
        # Entrada: datos/
        run: tar -czvf backup/datos-backup.tar.gz datos

      # 4. Sube el archivo comprimido como un artefacto
      - name: Upload backup artifact
        uses: actions/upload-artifact@v5
        with:
          # Nombre que tendrá el artefacto en GitHub
          name: backup-de-datos
          # Ruta al archivo que queremos subir
          path: backup/datos-backup.tar.gz