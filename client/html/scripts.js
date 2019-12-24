var itemName = null;
var itemAmount = null;
var itemIdname = null;

$(document).ready(function () {

  $(".container").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome();
    }
    if (item.show == false) {
      close();
    }
    if (item.inventory) {
      //console.log(JSON.stringify(item.inventory, null, 2));
      $("#items").empty();
      item.inventory.forEach(element => {
        $("#items").append(`
          <div onclick="SelecionaItens(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" style="background-image: url('assets/icons/${element.icon}');">
            <p class="amount">x${element.amount}</p>
            <p class="name">${element.name}</p>
          </div>
        `);
        console.log(element.name)
      });
    }
    if (item.notification == true) {
      Swal.fire(
        item.title,
        item.message,
        item.type
      )
    }
    if(item.weight && item.maxWeight) {
      $(".weight").html(item.weight + "/" + item.maxWeight + " kg");
      //$(".weight").html("200.00/200.00 KG");
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://vrpex-inventory/close', JSON.stringify({}));
      $(".container").hide();
      $("body").css("background-image", "none");
    }
  };
  $(".btnClose").click(function () {
    $.post('http://vrpex-inventory/close', JSON.stringify({}));
    $(".container").hide();
    $("body").css("background-image", "none");
  });
});

function open() {
  $(".container").show();
  $("body").css("background-image", "radial-gradient(ellipse farthest-corner at 45px 45px, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.4) )");
  $("#home").css("display", "show");
  clearSelectedItem();
}
function close() {
  $("#home").css("display", "none");
  
  clearSelectedItem();
}
function openHome() {
  $("#home").css("display", "block");
}

function SelecionaItens(element) {
  itemName = element.dataset.name;
  itemAmount = element.dataset.amount;
  itemDesc = element.dataset.item_desc;
  itemIdname = element.dataset.idname;
  $("#items div").css("background-color", "rgba(0, 0, 0, 0.29)");
  $(element).css("background-color", "rgba(170, 92, 170, 0.651)");
}

function useItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Você deve selecionar alguma coisa para continuar',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não tem essa quantidade para usar!',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrpex-inventory/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Você deve selecionar alguma coisa para continuar',
        'warning'
      )
    }
  }
}

function dropItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Você deve selecionar alguma coisa para continuar',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você deve selecionar alguma coisa para continuar',
      'warning'
    )
  } else {
    if(itemIdname !== null) {
      $.post('http://vrpex-inventory/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Você deve selecionar alguma coisa para continuar',
        'warning'
      )
    }
  }
}

function giveItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Você deve selecionar alguma coisa para continuar',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você deve selecionar alguma coisa para continuar',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrpex-inventory/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Você deve selecionar alguma coisa para continuar',
        'warning'
      )
    }
  }
}


function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
}
