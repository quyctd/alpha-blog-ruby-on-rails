//= require jquery3
//= require rails-ujs
//= require popper
//= require bootstrap
//= require turbolinks

function doSomeThing() {
    const files = document.querySelector('.file-upload-field').files;
    const file = files[0];
    const item = document.querySelector(".file-upload-wrapper");
    $(item).attr("data-text", file.name.replace(/.*(\/|\\)/, '') );
}