# The `src/common/` Directory

The `src/common/` directory is reusable components that serve as the business logic of the application. They may be specific to this application, but should be organized so that they can be easily copied and reused in another application. In general user visible components like directives, controllers, states, and templates should not live here.

```
src/
  |- common/
  |  |- backend/
  |  |- resources
```

- `backend` - this houses the general module which handles communication with the backend server
- `resources` - this houses sub-classes of BackendResource which provide an object oriented interface to backend data, and AppBackend, which provides app specific endpoints to the backend

