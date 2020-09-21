#ifndef BRANCH_MERGE_BAR_H
#define BRANCH_MERGE_BAR_H

struct thing {
    int *x;
    thing(int x, int y) {
        this->x = new int[2];
        this->x[0] = x;
        this->x[1] = y;
    }

    thing(thing&& rhs) {
        this->x = rhs.x;
        rhs.x = nullptr;
    }

    thing(thing& rhs) {
        this->x = new int[2];
        this->x[0] = rhs.x[0];
        this->x[1] = rhs.x[1];
    }

    thing& operator=(thing&& rhs) {
        if (this != &rhs) {
            delete this->x;
            this->x = rhs.x;
            rhs.x = nullptr;
        }
        return *this;
    }

    ~thing() {
        delete this->x;
    }

    friend thing operator+(const thing lhs, const thing& rhs) {
        return thing(lhs.x[0] + rhs.x[0], lhs.x[1] + rhs.x[1]);
    }

    friend thing operator+(const thing lhs, const int& rhs) {
        return thing(lhs.x[0] + rhs, lhs.x[1]);
    }
};

int do_struct_things(int x, int y);

#endif
