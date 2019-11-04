let myMap;

$(document).ready(function () {
    let cartSettings = $('#map_settings');
    let cartSettingsCoordinates = cartSettings.data('coordinates');
    let cartSettingsZoom = cartSettings.data('zoom');

    $('#add-building').click(function () {
        addBuilding()
    });
    ymaps.ready(function () {
        myMap = new ymaps.Map("map", {
            center: cartSettingsCoordinates,
            zoom: cartSettingsZoom
        });

        myMap.events.add('click', function (e) {
        if (!myMap.balloon.isOpen()) {
            var coords = e.get('coords');
            myMap.balloon.open(coords, {
                contentHeader:'Событие!',
                contentBody:'<p>Кто-то щелкнул по карте.</p>' +
                    '<p>Координаты щелчка: ' + [
                        coords[0].toPrecision(8),
                        coords[1].toPrecision(8)
                    ].join(', ') + '</p>',
                contentFooter:'<sup>Щелкните еще раз</sup>'
            });
        }
        else {
            myMap.balloon.close();
        }
        });

        myMap.events.add('click', function (e) {
            let coords = e.get('coords');
            myMap.geoObjects.removeAll();
            myMap.setCenter(coords);
            getBuildings(myMap, coords);
        });

        getBuildings(myMap);
    });
});

function addStick(data) {
    $(data).each(function (i, item) {
        myMap.geoObjects.add(new ymaps.Placemark([parseFloat(item['latitude']), parseFloat(item['longitude'])], {}, {
            preset: 'islands#circleIcon',
            iconColor: '#3caa3c'
        }))
    })
}

function getBuildings(myMap = null, coords = null) {
    
    let $form = $('#buildings-tables');
    $.ajax({
        url: $form.data('url'),
        type: 'GET',
        dataType: 'json',
        success: function (data, request) {
            if (request === 'success') {
                reloadTable(data);
                if (myMap !== null) {
                    addStick(data)
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $.bootstrapGrowl(jqXHR['responseJSON']['data'], {type: 'danger'});
        }
    });
}

function reloadTable(data) {
    $('#table-body').empty();
    if (data.length > 0) {
        $(data).each(function (i, item) {
            $('#table-body').append(
                '<tr>' +
                '<td>' + (i + 1) + '</td>' +
                '<td>' + item["address"] + '</td>' +
                '<td>' + item["distance"] + '</td>' +
                '<td  data-url="' + item["url"] + '">' +
                '<span title="Редактировать" ' +
                'class="glyphicon glyphicon-pencil text-warning" ' +
                'aria-hidden="true"></span>' +
                '<span title="Удалить" class="glyphicon glyphicon-remove text-danger" onclick="destroyBuilding(this)" aria-hidden="true"></span>' +
                '</td>' +
                '</tr>')
        })
    } else {
        $('#table-body').append(
            '<tr class="text-center">' +
            '<td colspan="5">Не добавлено ни одного здания</td>' +
            '</tr>')
    }
}

function addBuilding() {
    let $form = $('#building-form');
    $.ajax({
        url: $form.data('url'),
        type: 'POST',
        dataType: 'json',
        data: $form.serialize(),
        success: function (data, request) {
            console.log(data);
            if (request === 'success') {
                getBuildings();
                $.bootstrapGrowl(data['message'], {type: 'success'});
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $.bootstrapGrowl(jqXHR['responseJSON']['data'], {type: 'danger'});
        }

    });
}

function destroyBuilding(el) {
    let $url = $(el).parent().data('url');
    $.ajax({
        url: $url,
        type: 'DELETE',
        dataType: 'json',
        success: function (data, request) {
            if (request === 'success') {
                getBuildings();
                $.bootstrapGrowl(data['message'], {type: 'success'});
            }
        },
        error: function () {
            $.bootstrapGrowl('Ошибка', {type: 'danger'});
        }

    });
}
