import { describe, expect, it } from "vitest";

import { defineState } from "@ir-engine/hyperflux";
import { defineState as defineStateNested } from "@ir-engine/hyperflux/src/functions/StateFunctions";

describe("Hyperflux", () => {
  it("should define state using top level import", () => {
    const state = defineState({ name: "my-state", initial: {} });
    expect(state).toBeDefined();
  });

  it("should define state using nested import", () => {
    const state = defineStateNested({ name: "my-state-nested", initial: {} });
    expect(state).toBeDefined();
  });

  it("top level and nested imports should be same definition", () => {
    expect(defineState).toBe(defineStateNested);
  });
});
