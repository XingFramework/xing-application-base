Ninja.behavior({
    '.mizugumo_graceful_form': Ninja.becomesLink,
    '.flash': Ninja.decays({ lifetime : 5000}),
    '*[data-confirm]': Ninja.confirms
  })
