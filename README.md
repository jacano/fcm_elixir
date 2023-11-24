# Reservation Transformer (FCM Technical challenge)
This Elixir app processes reservation data from an input file and shows the transformed data on the console. For complete details, refer to the challenge description [here](https://github.com/fcm-digital/elixir_technical_challenge/blob/master/README.md).

## Getting Started

Make sure you have Erlang and Elixir installed. Clone the repository and navigate to the project directory in your terminal.

## Usage

1. **Compiling and Running:**
   - Compile the project: `mix compile`.
   - Run the app: `mix run`.

2. **Escript Execution:**
   - Generate an escript executable:
     ```bash
     mix escript.build
     ```
   - Run the escript with the input file path:
     ```bash
     ./fcm_challenge --input <input_file_path>
     ```

## Code Structure

- `Test.MixProject` Module:
  - Holds project configuration settings for dependencies, versions, Elixir compatibility, and escript creation.
- `ReservationTransformer` Module:
  - Handles processing and transforming the input file in multiple steps:
    1. **Reading and Filtering:**
        - Reads and filters valid reservation lines based on predefined criteria.

    2. **Segmentation and Sorting:**
        - Splits reservations into 'based' and trip 'segments', sorting segments using a comparison function.

    3. **Trip Grouping and Summary:**
        - Groups segments into trips and creates trip summaries by excluding base segments and detailing trip destinations.

    4. **Formatting and Output:**
        - Formats trip summaries and segments into a final output string for display.

## Testing
´test´ directory holds the test suite with input files and expected output and unit tests for modules.

## Dependencies
- Erlang 24 (Ensure binaries are included in the `Path` environment variable)
- Elixir 1.15.7

## IDE
- VScode 1.84.2
  * ElixirLS: Elixir support and debugger v0.17.10
  * Elixir Test v1.8.0