input_data = [0,1,2,4,5,7]
tmp = []

# for i in range(len(input_data)-1):
    # if i == 0:
        # tmp1 = input_data[i]
    # if i == len(input_data) - 2:
        # if input_data[i]+1 != input_data[i+1]:
            # tmp.append("%d->%d" % (tmp1, input_data[i]))
            # tmp.append("%d" % (input_data[i+1]))
        # else:
            # tmp.append("%d->%d" % (tmp1, input_data[i+1]))
    # else:
        # if input_data[i]+1 != input_data[i+1]:
            # tmp.append("%d->%d" % (tmp1, input_data[i]))
            # tmp1 = input_data[i+1]

start = end = input_data[0]
for i in range(1, len(input_data)):
    if input_data[i] == end+1:
        end = input_data[i]
        continue
    print start, "->", end
    start = end = input_data[i]
print start, "->", end


# vector<string> summaryRanges(vector<int>& nums) {
    # vector<string> result;
    # int len = nums.size();
    # if (len == 0) return result;

    # // we have two pointer for range-starter and range-ender
    # int start=nums[0], end=nums[0];

    # for (int i=1; i<len; i++) {
        # // if it is continous number, move the end pointer;
        # if (nums[i] == end + 1) {
            # end = nums[i];
            # continue;
        # }

        # //if the number is not continous, push the range into result
        # //and reset the start and end pointer
        # result.push_back(makeRange(start, end));
        # start = end = nums[i];

    # }

    # //for the last range
    # result.push_back(makeRange(start, end));

    # return result;
# }

