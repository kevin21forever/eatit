function countUp(count)
{
    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $('.count1'),
        run_count = 1,
        int_speed = 24;
    var int = setInterval(function() {
        if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count+"%");
        } else {
            clearInterval(int);
        }
    }, int_speed);
}


function countUp2(count)
{

    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $('.count2'),
        run_count = 1,
        int_speed = 24;

    var int2 = setInterval(function() {

     if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count);
        } else {
            clearInterval(int2);
        }
    }, int_speed);
}

function countUp3(count)
{
    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $('.count3'),
        run_count = 1,
        int_speed = 24;

    var int3 = setInterval(function() {
         if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count);
        } else {
            clearInterval(int3);
        }
    }, int_speed);
}


function countUp4(count)
{
    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $('.count4'),
        run_count = 1,
        int_speed = 24;

    var int4 = setInterval(function() {
     if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count);
        } else {
            clearInterval(int4);
        }
    }, int_speed);
}

function countUp5(count)
{
    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $('.count5'),
        run_count = 1,
        int_speed = 24;

    var int5 = setInterval(function() {
        if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count);
        } else {
            clearInterval(int5);
        }
    }, int_speed);
}



