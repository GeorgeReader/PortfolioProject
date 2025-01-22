--------- President Election Power Bi DAX coding Measures -----------

--- Starting with election_results dataset from https://www.presidency.ucsb.edu/statistics/elections
--- Creating a visual map showing highest percentage of voters by state.

--- Starting with finding winning candidate 

president_winner_name = 
VAR TrumpVotes2020 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2020
    )
VAR TrumpVotes2024 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2024
    )
VAR BidenVotes = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Joe Biden"
    )
VAR KamalaVotes = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Kamala Harris"
    )
VAR OtherVotes2020 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2020
    )
VAR OtherVotes2024 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2024
    )
RETURN
    IF(
        TrumpVotes2020 > BidenVotes && 
        TrumpVotes2020 > OtherVotes2020 + OtherVotes2024, 
        "Donald Trump", 
    IF(
        TrumpVotes2024 > KamalaVotes && 
        TrumpVotes2024 > OtherVotes2020 + OtherVotes2024, 
        "Donald Trump", 
    IF(
        BidenVotes > TrumpVotes2020 && 
        BidenVotes > OtherVotes2020 + OtherVotes2024, 
        "Joe Biden", 
    IF(
        KamalaVotes > TrumpVotes2024 && 
        KamalaVotes > OtherVotes2020 + OtherVotes2024, 
        "Kamala Harris", 
    IF(
        OtherVotes2020 + OtherVotes2024 > TrumpVotes2020 + TrumpVotes2024 && 
        OtherVotes2020 + OtherVotes2024 > BidenVotes && 
        OtherVotes2020 + OtherVotes2024 > KamalaVotes, 
        "Other", 
        "No Winner"
    )))))

---- Using similiar code to create custom legend for map visual

president_winner_color = 
VAR TrumpVotes2020 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2020
    )
VAR TrumpVotes2024 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2024
    )
VAR BidenVotes = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Joe Biden"
    )
VAR KamalaVotes = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Kamala Harris"
    )
VAR OtherVotes2020 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2020
    )
VAR OtherVotes2024 = 
    CALCULATE(
        SUM('election_results'[votes]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2024
    )
RETURN
    IF(
        TrumpVotes2020 > BidenVotes && 
        TrumpVotes2020 > OtherVotes2020 + OtherVotes2024, 
        "Red", 
    IF(
        TrumpVotes2024 > KamalaVotes && 
        TrumpVotes2024 > OtherVotes2020 + OtherVotes2024, 
        "Red", 
    IF(
        BidenVotes > TrumpVotes2020 && 
        BidenVotes > OtherVotes2020 + OtherVotes2024, 
        "Blue", 
    IF(
        KamalaVotes > TrumpVotes2024 && 
        KamalaVotes > OtherVotes2020 + OtherVotes2024, 
        "Blue", 
    IF(
        OtherVotes2020 + OtherVotes2024 > TrumpVotes2020 + TrumpVotes2024 && 
        OtherVotes2020 + OtherVotes2024 > BidenVotes && 
        OtherVotes2020 + OtherVotes2024 > KamalaVotes, 
        "Yellow", 
        "No Winner"
    )))))

--- Next going to polling  with president_polls_historian dataset from https://projects.fivethirtyeight.com/. 
--- Creating another visual map showing percentage of voters polling data by state.

--- Starting with finding winning candidate

polling_winner_name = 
VAR TrumpVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Trump"
    )
VAR BidenVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Biden"
    )
VAR HarrisVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Harris"
    )
VAR OtherVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        NOT 'president_polls_historical'[answer] IN {"Trump", "Biden", "Harris"}
    )
RETURN
    IF(TrumpVotes > BidenVotes && TrumpVotes > HarrisVotes && TrumpVotes > OtherVotes, "Donald Trump", 
    IF(BidenVotes > TrumpVotes && BidenVotes > HarrisVotes && BidenVotes > OtherVotes, "Joe Biden", 
    IF(HarrisVotes > TrumpVotes && HarrisVotes > BidenVotes && HarrisVotes > OtherVotes, "Kamala Harris", 
    "Other")))

---- Using same code to create custom legend for map visual

polling_winner_color = 
VAR TrumpVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Trump"
    )
VAR BidenVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Biden"
    )
VAR HarrisVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        'president_polls_historical'[answer] = "Harris"
    )
VAR OtherVotes = 
    CALCULATE(
        AVERAGE('president_polls_historical'[pct]),
        NOT 'president_polls_historical'[answer] IN {"Trump", "Biden", "Harris"}
    )
RETURN
    IF(TrumpVotes > BidenVotes && TrumpVotes > HarrisVotes && TrumpVotes > OtherVotes, "Red", 
    IF(BidenVotes > TrumpVotes && BidenVotes > HarrisVotes && BidenVotes > OtherVotes, "Blue", 
    IF(HarrisVotes > TrumpVotes && HarrisVotes > BidenVotes && HarrisVotes > OtherVotes, "Blue", 
    "Other")))

--- Finally evaluating the change voting results from previous cycle from election-results dataset
--- Add new column to show diiferential of votes between 2020 and 2024
--- Creating visual map showing voter differential by results of previous cycle.

vote_differential = 
VAR pct_2020 = 
    CALCULATE(
        MAX(election_results[pct_votes]),
        election_results[cycle] = 2020,
        ALLEXCEPT(election_results, election_results[state], election_results[party])
    )
VAR pct_2024 = 
    CALCULATE(
        MAX(election_results[pct_votes]),
        election_results[cycle] = 2024,
        ALLEXCEPT(election_results, election_results[state], election_results[party])
    )
RETURN 
    IF(election_results[cycle] = 2020, pct_2020 - pct_2024, 
        IF(election_results[cycle] = 2024, pct_2024 - pct_2020, 0))

--- Finding large percent of voter change between candidates

vote_differential_name = 
VAR RepVoteDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "REP"
    )
VAR DemVotesDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Joe Biden",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "DEM"
    )
VAR ThirdVotesDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "Third"
    )
VAR RepVoteDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "REP"
    )
VAR DemVotesDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Kamala Harris",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "DEM"
    )
VAR ThirdVotesDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "Third"
    )
RETURN
    IF(
        RepVoteDiff24 > DemVotesDiff24 && RepVoteDiff24 > ThirdVotesDiff24, 
        "Donald Trump",
    IF(
        DemVotesDiff24 > RepVoteDiff24 && DemVotesDiff24 > ThirdVotesDiff24, 
        "Joe Biden",
    IF(
        ThirdVotesDiff24 > RepVoteDiff24 && ThirdVotesDiff24 > DemVotesDiff24,  
        "Other",
    IF(
        RepVoteDiff20 > DemVotesDiff20 && RepVoteDiff20 > ThirdVotesDiff20, 
        "Donald Trump",
    IF(
        DemVotesDiff20 > RepVoteDiff20 && DemVotesDiff20 > ThirdVotesDiff20, 
        "Kamala Harris",
    IF(
        ThirdVotesDiff20 > RepVoteDiff20 && ThirdVotesDiff20 > DemVotesDiff20, 
        "Other"
    ))))))

---- Using similiar code to create customize legend for map visual

vote_differential_color = 
VAR RepVoteDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "REP"
    )
VAR DemVotesDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Joe Biden",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "DEM"
    )
VAR ThirdVotesDiff20 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2020,
        'election_results'[party] = "Third"
    )
VAR RepVoteDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Donald Trump",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "REP"
    )
VAR DemVotesDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Kamala Harris",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "DEM"
    )
VAR ThirdVotesDiff24 = 
    CALCULATE(
        MAX('election_results'[vote_differential]),
        'election_results'[candidate] = "Other",
        'election_results'[cycle] = 2024,
        'election_results'[party] = "Third"
    )
RETURN
    IF(
        RepVoteDiff24 > DemVotesDiff24 && RepVoteDiff24 > ThirdVotesDiff24, 
        "Red",
    IF(
        DemVotesDiff24 > RepVoteDiff24 && DemVotesDiff24 > ThirdVotesDiff24, 
        "Blue",
    IF(
        ThirdVotesDiff24 > RepVoteDiff24 && ThirdVotesDiff24 > DemVotesDiff24,  
        "Yellow",
    IF(
        RepVoteDiff20 > DemVotesDiff20 && RepVoteDiff20 > ThirdVotesDiff20, 
        "Red",
    IF(
        DemVotesDiff20 > RepVoteDiff20 && DemVotesDiff20 > ThirdVotesDiff20, 
        "Blue",
    IF(
        ThirdVotesDiff20 > RepVoteDiff20 && ThirdVotesDiff20 > DemVotesDiff20, 
        "Yellow"
    ))))))