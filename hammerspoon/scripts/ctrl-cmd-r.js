function run(argv) {;
    // Rename keepit files according to their modification date, then move them into Life/Year;
    var keepit = Application("Keep It");
    var life = null;;
    let folders = keepit.folders();
    for (let folder of folders) {;
        if (folder.name() == "Life") {;
            life = folder;
            break;
        };
    };
    var years = {};;
    for (let folder of life.folders()) {;
        years[folder.name()] = folder;
    };
;
    keepit.selectedItems().forEach(function(item) {;
        let ctime = JSON.stringify(item.created()).split('T')[0].replace('"', '');
        let year = ctime.split('-')[0];
        /*if (!item.name().startsWith(ctime)) {
          item.name = ctime + " " + item.name()
          }*/
        if (!years.hasOwnProperty(year)) {;
            years[year] = new keepit.Folder({name: year, parentFolder: life});
        };
        console.log(item.name());
        item.move({to: years[year]});
    });
};
