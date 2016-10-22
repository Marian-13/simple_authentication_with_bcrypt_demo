const Sessions = {
  focusOn: (id) => {
    if (event.keyCode == 13) {
      event.preventDefault();
      document.getElementById(id).focus();
    }
  }
}

console.log('Hello');
