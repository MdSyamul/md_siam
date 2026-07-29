{{flutter_js}}
{{flutter_build_config}}

function showStartupError(error) {
  console.error('Flutter startup failed:', error);
  const loadingMessage = document.getElementById('loading-message');
  if (loadingMessage) {
    loadingMessage.textContent =
      'The website could not finish loading. Please refresh or open this link in your browser.';
  }
}

_flutter.loader.load({
  config: {
    canvasKitBaseUrl: 'canvaskit/',
  },
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();

    const loadingScreen = document.getElementById('app-loading');
    if (loadingScreen) {
      loadingScreen.classList.add('is-ready');
      loadingScreen.addEventListener(
        'transitionend',
        function () {
          loadingScreen.remove();
        },
        { once: true },
      );
    }
  },
}).catch(showStartupError);
