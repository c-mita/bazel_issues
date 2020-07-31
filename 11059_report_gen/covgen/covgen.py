import argparse
import time

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("--output_file", type=str)
    parser.add_argument("--reports_file", type=str)
    args = parser.parse_args()
    out_file = args.output_file
    time.sleep(3)

    with open(out_file, "w") as f:
        print(str(time.time()), file=f)
        print("FAKE COVERAGE STUFF", file=f)

if __name__=="__main__":
    main()
