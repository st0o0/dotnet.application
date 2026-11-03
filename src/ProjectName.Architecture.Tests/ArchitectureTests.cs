using ArchUnitNET.Loader;
using static ArchUnitNET.Fluent.ArchRuleDefinition;
using Arch = ArchUnitNET.Domain.Architecture;

namespace ProjectName.Architecture.Tests;

public sealed class ArchitectureTests
{
    private static readonly Arch Architecture = new ArchLoader()
        .LoadAssemblies(
            typeof(Program).Assembly,
            typeof(Core.Class1).Assembly,
            typeof(Messages.Class1).Assembly)
        .Build();

    [Fact]
    public void Messages_Should_Not_Reference_Core()
    {
        var messagesTypes = Types().That().ResideInAssembly(typeof(Messages.Class1).Assembly);
        var coreTypes = Types().That().ResideInAssembly(typeof(Core.Class1).Assembly);

        var rule = messagesTypes.Should().NotDependOnAny(coreTypes);
        rule.Check(Architecture);
    }
}
