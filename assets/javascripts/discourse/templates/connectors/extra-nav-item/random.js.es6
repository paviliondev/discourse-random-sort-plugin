export default {
  shouldRender(args, component) {
    const filterMode = component.get("filterMode");
    return filterMode != "random";
  }
};
