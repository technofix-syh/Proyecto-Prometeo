# Hoja de Ruta del Proyecto Prometeo

Esta es la hoja de ruta estimada a muy largo plazo para el desarrollo del Proyecto Prometeo. **Los tiempos son optimistas y están sujetos a cambios** basados en la disponibilidad de contribuyentes.

## Fase 0: Cimientos y Arquitectura (Años 1-2)
- [ ] Documento de Diseño Arquitectónico detallado.
- [ ] Entorno de desarrollo (Toolchain, QEMU).
- [ ] Primer kernel booteable ("Hola, Prometeo").
- [ ] Sistema de IPC funcional entre procesos de usuario.

## Fase 1: El "Traductor" para Linux (Años 3-5)
- [ ] Integración de una capa de compatibilidad de Linux (`liblinux`).
- [ ] Ejecución de shells y herramientas básicas de Linux (`bash`, `coreutils`).
- [ ] Soporte para APIs gráficas y de audio (OpenGL, ALSA).

## Fase 2: Integración de Windows NT (Años 6-9)
- [ ] Servidor de Personalidad Win32 (basado en Wine/ReactOS).
- [ ] Integración de GUI (APIs GDI/DirectX).
- [ ] Ejecución estable de aplicaciones clave de Windows.

## Fase 3: Conquista de macOS (Años 10-13)
- [ ] Servidor de Personalidad Darwin (basado en Darling).
- [ ] Implementación de frameworks de UI de macOS (Cocoa).
- [ ] Ejecución de aplicaciones nativas de macOS.

## Fase 4: Optimización y Ecosistema (Años 14-15+)
- [ ] Reemplazo de componentes prestados por implementaciones nativas.
- [ ] Creación del Meta-SDK.
- [ ] Instalador y primera distribución estable.
