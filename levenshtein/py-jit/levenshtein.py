from numba import njit, int32

@njit
def levenshtein_distance(str1: str, str2: str) -> int32:
    if (len(str2) < len(str1)):
        return levenshtein_distance(str2, str1)
    m, n = len(str1), len(str2)

    prev = [0] * (m+1)
    curr = [0] * (m+1)

    for i in range(m + 1):
        prev[i] = i

    # Compute Levenshtein distance
    for i in range(1, n + 1):
        curr[0] = i
        for j in range(1, m + 1):
            # Cost is 0 if characters match, 1 if they differ
            cost = 0 if str1[j-1] == str2[i-1] else 1
            curr[j] = min(
                prev[j] + 1,      # Deletion
                curr[j-1] + 1,      # Insertion
                prev[j-1] + cost  # Substitution
            )
        for j in range(m+1):
            prev[j] = curr[j]

    return prev[m]

@njit
def distances(strings: list[str]) -> list[int32]:
    # collect the distance between any pairing of strings
    num_strings = len(strings)
    dists = []
    for i in range(num_strings):
        for j in range(i + 1, num_strings):
            dists.append(levenshtein_distance(strings[i], strings[j]))
    return dists