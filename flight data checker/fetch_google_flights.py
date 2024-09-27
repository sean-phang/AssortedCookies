from serpapi import GoogleSearch
import json
import os

class Trip:
   def __init__(self, departure_airport, arrival_airport, outbound_date, return_date, duration, price, type, flights):
        self.departure_airport = departure_airport
        self.arrival_airport = arrival_airport
        self.outbound_date = outbound_date
        self.return_date = return_date
        self.duration = duration
        self.price = price
        self.type = type
        self.flights = flights

class Flight:
    def __init__(self, flight_number, departure_airport, arrival_airport, airplane, airline, duration):
        self.flight_number = flight_number
        self.departure_airport = departure_airport
        self.arrival_airport = arrival_airport
        self.airplane = airplane
        self.airline = airline
        self.duration = duration

AIRPORTS = ["SIN", "KIX", "HND"]
SOURCE = "SIN"
MIN_STAY = 3
TOTAL_DURATION = 14
START_DATE = "2024-10-19"
END_DATE = "2024-11-03"

#  from datetime import datetime, timedelta
#  datetime.strptime(d, '%Y-%m-%d').date() + timedelta(days=1)

params = {
    "engine": "google_flights",
    "hl": "en",
    "gl": "sg",
    "departure_id": "SIN",
    "arrival_id": "KIX",
    "outbound_date": "2024-09-28",
    # "return_date": "2024-10-04",
    "currency": "SGD",
    "adults": "1",
    # 0 - Any number of stops (default)
    # 1 - Nonstop only
    # 2 - 1 stop or fewer
    # 3 - 2 stops or fewer
    "stops": "1",
    # 1 - Round trip (default)
    # 2 - One way
    # 3 - Multi-city
    "type": "2",
    "api_key": "API_KEY"
}

def read_json_data(file):
    trips = []
    results = json.load(file)

    for trip in results["other_flights"]:
        flights = []
        for flight_info in trip["flights"]:
            flights.append(Flight(flight_info["flight_number"],
                        flight_info["departure_airport"],
                        flight_info["arrival_airport"],
                        flight_info["airplane"],
                        flight_info["airline"],
                        flight_info["duration"]))
            
        trips.append(Trip(results["search_parameters"]["departure_id"],
                        results["search_parameters"]["arrival_id"],
                        results["search_parameters"]["outbound_date"],
                        results["search_parameters"]["return_date"],
                        trip["total_duration"],
                        trip["price"],
                        trip["type"],
                        trip["flights"]))
    return trips

def main():
    # search = GoogleSearch(params)
    # results = search.get_dict()
    os.makedirs("./flight_data", exist_ok=True)
    filename = None

    trips = None
    with open('/home/sean/Documents/TrashMountain/flight data checker/test.json', 'r') as f:
        # trips = read_json_data(f)
        results = json.load(f)
    
        filename = "_".join([results["search_parameters"]["departure_id"],
                             results["search_parameters"]["arrival_id"],
                             results["search_parameters"]["outbound_date"],
                             results["search_parameters"]["return_date"],])

        with open("flight_data/"+filename, "w") as fw:
            fw.write(json.dumps(results))
            # print(trips[0].departure_airport)

if __name__ == "__main__":
    main()