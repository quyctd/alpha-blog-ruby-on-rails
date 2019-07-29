console.log("custom js file loaded");

$(window).scroll(function () {
    if ($(window).scrollTop() >= 30) {
        $('.navbar').addClass('navbar-light bg-light shadow');
        $('.navbar').removeClass('navbar-dark bg-transparent');
    } else {
        $('.navbar').removeClass('navbar-light bg-light shadow');
        $('.navbar').addClass('navbar-dark bg-transparent');
    }
});