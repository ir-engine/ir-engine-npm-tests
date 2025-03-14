import { defineState } from "@ir-engine/hyperflux";
import { describe, expect, it } from "vitest";

describe("Hyperflux", () => {
  it("should define state", () => {
    const state = defineState({ name: "my-state", initial: {} });
    expect(state).toBeDefined();
  });
});
