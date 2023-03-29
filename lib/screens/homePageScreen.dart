import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/measures.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/repository/weatherRepo.dart';
import 'package:weather_app/screens/bottomScreen.dart';
import 'package:weather_app/screens/weatherInformation.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final _locationController = TextEditingController();
  bool isDay = true;
  bool saveButton = true;
  List<String> _recentLocations = [];

  // for background image
  void checkDayOrNight(String query) {
    WeatherRepoImpl().weatherInformation(query).then((value) {
      if (value!.current!.is_day == 1) {
        setState(() {
          isDay = true;
        });
      } else {
        setState(() {
          isDay = false;
        });
      }
    });
  }

  // save data to shared_preference
  void saveData(String locationName) async {
    final prefs = await SharedPreferences.getInstance(); // getting instance
    List<String>? data =
        prefs.getStringList('location'); // getting value by key
    // if inserting data for the first time
    if (data == null || data.isEmpty) {
      // if locationName is empty do not insert
      if (locationName != "") {
        await prefs.setStringList(
            'location', [locationName.toLowerCase()]).whenComplete(() {});
        return;
      }
      return;
    }
    // if the list already contains the data(location)
    if (!data.contains(locationName.toLowerCase())) {
      // add inupt data
      data.add(locationName);
      // update the data and save
      await prefs.setStringList('location', data).whenComplete(() {
        recentSearch();
      });
    }
  }

  // to Update the button (save/update)
  void _updateButton(String value) {
    if (value.isNotEmpty) {
      saveButton = false;
      return;
    }
    saveButton = true;
  }

  // to set the inital background image (day/night)
  void initalDay() async {
    await WeatherRepoImpl().weatherInformation("27.7172,85.3240").then((value) {
      if (value!.current!.is_day == 1) {
        setState(() {
          isDay = true;
        });
      } else {
        setState(() {
          isDay = false;
        });
      }
    });
  }

  // get recent search data
  void recentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('location');
    if (data != null || data!.isNotEmpty) {
      setState(() {
        _recentLocations = data;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for initial value
    initalDay();
    recentSearch();
  }

  void weatherInformation(WidgetRef ref) {
    ref.watch(weatherProvider.notifier).updateWeather(_locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    weatherInformation(ref);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
              height: 520,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // Background Image day/night
                      image: isDay
                          ? const AssetImage("assets/images/day.jpg")
                          : const AssetImage("assets/images/night.jpg"))),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    // search/textform bar
                    child: TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      onChanged: (value) => _updateButton(value),
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintText: "Search by Location Name",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        // search button
                        suffixIcon: Container(
                          width: 106,
                          height: 40,
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                              textColor: Colors.white,
                              color: const Color.fromARGB(255, 255, 172, 100),
                              onPressed: () {
                                if (_locationController.text.isEmpty) {
                                  setState(() {
                                    saveButton = true;
                                  });
                                } else {
                                  setState(() {
                                    saveButton = false;
                                  });
                                }
                                saveData(_locationController.text);
                              },
                              child: saveButton
                                  ? const Text("Save/Search")
                                  : const Text("Update")),
                        ),
                      ),
                    ),
                  ),
                  gap30,
                  // weather information
                  WeatherInformation(query: _locationController.text)
                ],
              ),
            ),
            // temperature view
            Positioned(
                bottom: 0,
                child: BottomInformation(query: _locationController.text)),
            // recents searched locations
            Positioned(
                top: 330,
                child: Container(
                  width: 375,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 1, blurRadius: 3, color: Colors.blue)
                    ],
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      gap10,
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Recents",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Colors.black,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -10))
                              ]),
                        ),
                      ),
                      Expanded(
                        child: _recentLocations.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Recent search",
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _recentLocations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      if (_locationController.text !=
                                          _recentLocations[index]) {
                                        setState(() {
                                          _locationController.text =
                                              _recentLocations[index];
                                        });
                                      }
                                    },
                                    title: Text(
                                        _recentLocations[index].toUpperCase()),
                                    trailing: const Icon(Icons.cached),
                                  );
                                }),
                      ),
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
