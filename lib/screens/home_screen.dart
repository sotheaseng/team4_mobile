import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:team4_weather/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
	const HomeScreen({super.key});

	@override
	State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
	// Function to get weather icon based on the condition code
	Widget getWeatherIcon(int code) {
		if (code >= 200 && code < 300) {
			return Image.asset('assets/1.png');
		} else if (code >= 300 && code < 400) {
			return Image.asset('assets/2.png');
		} else if (code >= 500 && code < 600) {
			return Image.asset('assets/3.png');
		} else if (code >= 600 && code < 700) {
			return Image.asset('assets/4.png');
		} else if (code >= 700 && code < 800) {
			return Image.asset('assets/5.png');
		} else if (code == 800) {
			return Image.asset('assets/6.png');
		} else if (code > 800 && code <= 804) {
			return Image.asset('assets/7.png');
		} else {
			return Image.asset('assets/7.png');
		}
	}

	// Function to determine the greeting based on the current time
	String getGreeting() {
		final hour = DateTime.now().hour;
		if (hour < 12) {
			return 'Good Morning';
		} else if (hour < 18) {
			return 'Good Afternoon';
		} else {
			return 'Good Evening';
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			extendBodyBehindAppBar: true,
			appBar: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				systemOverlayStyle: const SystemUiOverlayStyle(
					statusBarColor: Colors.transparent,
					statusBarIconBrightness: Brightness.dark,
					statusBarBrightness: Brightness.light,
				),
			),
			body: Padding(
				padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
								child: Container(
									decoration: const BoxDecoration(color: Colors.transparent),
								),
							),
							BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
								builder: (context, state) {
									if (state is WeatherBlocSuccess) {
										return SizedBox(
											width: MediaQuery.of(context).size.width,
											height: MediaQuery.of(context).size.height,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														'📍 ${state.weather.areaName}',
														style: const TextStyle(
															color: Colors.black,
															fontWeight: FontWeight.w300,
														),
													),
													const SizedBox(height: 8),
													Text(
														getGreeting(),
														style: const TextStyle(
															color: Colors.black,
															fontSize: 25,
															fontWeight: FontWeight.bold,
														),
													),
													getWeatherIcon(state.weather.weatherConditionCode!),
													Center(
														child: Text(
															'${state.weather.temperature!.celsius!.round()}°C',
															style: const TextStyle(
																color: Colors.black,
																fontSize: 55,
																fontWeight: FontWeight.w600,
															),
														),
													),
													Center(
														child: Text(
															state.weather.weatherMain!.toUpperCase(),
															style: const TextStyle(
																color: Colors.black,
																fontSize: 25,
																fontWeight: FontWeight.w500,
															),
														),
													),
													const SizedBox(height: 5),
													Center(
														child: Text(
															DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
															style: const TextStyle(
																color: Colors.black,
																fontSize: 16,
																fontWeight: FontWeight.w300,
															),
														),
													),
													const SizedBox(height: 30),
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														children: [
															Row(
																children: [
																	Image.asset(
																		'assets/11.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Sunrise',
																				style: TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w300,
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				DateFormat().add_jm().format(state.weather.sunrise!),
																				style: const TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w700,
																				),
																			),
																		],
																	),
																],
															),
															Row(
																children: [
																	Image.asset(
																		'assets/12.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Sunset',
																				style: TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w300,
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				DateFormat().add_jm().format(state.weather.sunset!),
																				style: const TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w700,
																				),
																			),
																		],
																	),
																],
															),
														],
													),
													const Padding(
														padding: EdgeInsets.symmetric(vertical: 5.0),
														child: Divider(
															color: Colors.grey,
														),
													),
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														children: [
															Row(
																children: [
																	Image.asset(
																		'assets/13.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Temp Max',
																				style: TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w300,
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				"${state.weather.tempMax!.celsius!.round()} °C",
																				style: const TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w700,
																				),
																			),
																		],
																	),
																],
															),
															Row(
																children: [
																	Image.asset(
																		'assets/14.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Temp Min',
																				style: TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w300,
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				"${state.weather.tempMin!.celsius!.round()} °C",
																				style: const TextStyle(
																					color: Colors.black,
																					fontWeight: FontWeight.w700,
																				),
																			),
																		],
																	),
																],
															),
														],
													),
												],
											),
										);
									} else {
										return const Center(child: CircularProgressIndicator());
									}
								},
							),
						],
					),
				),
			),
		);
	}
}
