const App = {
  focusOn: (id) => {
    if (event.keyCode == 13) {
      event.preventDefault();
      document.getElementById(id).focus();
    }
  }
}
