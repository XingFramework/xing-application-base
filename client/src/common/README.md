# The `src/common/` Directory

The `src/common/` directory is reusable components that server as the business logic of the application. They may be specific to this application, but should be organized so that they can be easily copied and reused in another application. In general user visible components like directives, controllers, states, and templates should not live here.

```
src/
  |- common/
  |  |- server/
  |  |- resources
```

- `server` - this houses the module which handles communication with the backend server
- `resources` - this houses sub-classes of ServerResponse which provide an object oriented interface to server data
