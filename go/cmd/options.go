package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/plugins/path_provider"
	"github.com/go-flutter-desktop/plugins/shared_preferences"
	"github.com/nealwon/go-flutter-plugin-sqlite"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(400, 800),
	flutter.AddPlugin(&path_provider.PathProviderPlugin{
		VendorName:      "gargakshit",
		ApplicationName: "passwd",
	}),
	flutter.AddPlugin(&shared_preferences.SharedPreferencesPlugin{
		VendorName:      "gargakshit",
		ApplicationName: "passwd",
	}),
	flutter.AddPlugin(sqflite.NewSqflitePlugin("myOrganizationOrUsername", "myApplicationName")),
}
